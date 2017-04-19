module Handler.Table where

import Import

data Menu = Main | Dessert | Drink deriving Show

getTableR :: TableId -> Handler Html
getTableR tableId = do
    mmenu <- lookupGetParam "menu"
    let menu = case mmenu of
            Nothing -> Main
            Just "principales" -> Main
            Just "postres" -> Dessert
            Just "bebidas" -> Drink
            Just _ -> Main

    table <- runDB $ get tableId
    defaultLayout $ do
        setTitle $ toHtml $ "Mesa " ++ show tableId
        $(widgetFile "menu")


postTableR :: TableId -> Handler Html
postTableR = error "Not yet implemented: postTableR"


getPopulateR :: Handler Text
getPopulateR = do
    runDB $ forM tables insert
    return "Populated"
    where
        tables :: [Table]
        tables = replicate 10 Table
