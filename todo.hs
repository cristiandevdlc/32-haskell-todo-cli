import System.Environment (getArgs)
import System.IO (appendFile, readFile, writeFile)
import System.Directory (doesFileExist)

file :: FilePath
file = "todos.txt"

main :: IO ()
main = do
  args <- getArgs
  case args of
    ("add":rest) -> appendFile file (unwords rest ++ "\n") >> putStrLn "Tarea guardada"
    ["list"] -> do exists <- doesFileExist file; content <- if exists then readFile file else return ""; mapM_ putStrLn (zipWith format [1..] (lines content))
    ["clear"] -> writeFile file "" >> putStrLn "Lista vaciada"
    _ -> putStrLn "Uso: todo add texto | list | clear"
  where format n text = show n ++ ". " ++ text
