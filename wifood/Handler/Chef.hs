module Handler.Chef where

import Import
import Database.Persist.Sql

getChefR :: Handler Html
getChefR = do
    orders' <- runDB $ selectList [] [Desc OrderCreatedAt]
    orders <- forM orders' getOrder
    defaultLayout $(widgetFile "chef")

getDeliveredR :: OrderId -> Handler Html
getDeliveredR orderId = do
    runDB $ delete orderId
    redirect ChefR


getOrder (Entity orderId order) = do
    table <- runDB $ get404 $ orderTableId order
    item <- runDB $ get404 $ orderItemId order
    return $ (orderId, tableNumber table, itemName item, orderCreatedAt order)
