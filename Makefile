default: run2

compile:
	ghc -package parallel-io -threaded Scraper.hs -o Scraper

run2: compile
	./Scraper +RTS -N2

clean:
	rm -rf Scraper Scraper.hi Scraper.o
