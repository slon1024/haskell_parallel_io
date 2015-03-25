import Control.Concurrent.ParallelIO
import Text.HandsomeSoup
import Text.XML.HXT.Core

textFromUrl url = do
  doc <- parsePage url
  print $ (url, length $ clean doc)

main = do
  links <- runX $ fromUrl "http://www.datatau.com" >>> css "td.title a" !"href"

  parallel_ $ map textFromUrl links
  stopGlobalPool

parsePage :: String -> IO [String]
parsePage url = runX $ fromUrl url  /> multi getText


punctuations = ['!', '"', '#', '$', '%', '(', ')', '.', ',', '?']
removePunctuation = filter (`notElem` punctuations)

specialSymbols = ['/', '-']
replaceSpecialSymbols = map $ (\c -> if c `elem` specialSymbols then ' ' else c)

clean texts = filter (not.null) $ map clean' texts
  where clean' = removePunctuation.replaceSpecialSymbols.unwords.words
