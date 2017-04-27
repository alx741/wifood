module Handler.Chef where

import Import
import Database.Persist.Sql

getChefR :: Handler Html
getChefR = do
    orders' <- runDB $ selectList [] [Desc OrderCreatedAt]
    orders <- forM orders' getOrder
    defaultLayout $(widgetFile "chef")


getOrder (Entity _ order) = do
    table <- runDB $ get404 $ orderTableId order
    item <- runDB $ get404 $ orderItemId order
    return $ (tableNumber table, itemName item, orderCreatedAt order)
