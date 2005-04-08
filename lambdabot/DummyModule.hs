
module DummyModule (theModule) where

import IRC

newtype DummyModule = DummyModule ()

theModule :: MODULE
theModule = MODULE dummyModule

dummyModule :: DummyModule
dummyModule = DummyModule ()

instance Module DummyModule () where
  moduleName   _ = "dummy"

  moduleHelp _ s = return $ case s of
        "dummy"       -> "print a string constant"
        "wiki"        -> "wiki urls"
        "paste"       -> "paste page url"
        "learn"       -> "another url"
        "eurohaskell" -> "urls are good"
        "moo"         -> "vegan-friendly command"
        _             -> "dummy module"

  moduleCmds   _ = return ["dummy","wiki","paste","learn","eurohaskell","moo"]
  process _ _ src cmd rest = case lookup cmd dummylst of
			       Nothing -> error "Dummy: invalid command"
                               Just f -> ircPrivmsg src $ f rest

dummylst :: [(String, String -> String)]
dummylst = [("dummy",       \_ -> "dummy"),
	    ("eurohaskell", \_ -> unlines ["less talks, more code!",
					   "http://www.haskell.org/hawiki/EuroHaskell",
					   "EuroHaskell - Haskell Hackfest - Summer 2005 ",
                                                "- Gothenburg, Sweden"]),
	    ("wiki",        \x -> "http://www.haskell.org/hawiki/" ++ x),
	    ("paste",       \_ -> "http://www.haskell.org/hawiki/HaskellIrcPastePage"),
	    ("learn",       \_ -> "http://www.haskell.org/learning.html"),
	    ("moo",         \_ -> unlines ["         (__)",
					   "         (oo)",
					   "   /------\\/",
					   "  / |    ||",
					   " *  /\\---/\\",
					   "    ~~   ~~",
					   "....\"Have you mooed today?\"..." ])]
