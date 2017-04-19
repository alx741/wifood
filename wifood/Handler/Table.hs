module Handler.Table where

import Import
import ItemKind

getTableR :: TableId -> Handler Html
getTableR tableId = do
    mmenu <- lookupGetParam "menu"
    let menu = case mmenu of
            Nothing -> Main
            Just "principales" -> Main
            Just "postres" -> Dessert
            Just "bebidas" -> Drink
            Just _ -> Main

    menuItems <- loadMenuItems menu
    table <- runDB $ get tableId
    defaultLayout $ do
        setTitle $ toHtml $ "Mesa " ++ show tableId
        $(widgetFile "menu")

    where
        loadMenuItems kind = do
            runDB $ selectList [ItemItemKind ==. kind] []


postTableR :: TableId -> Handler Html
postTableR = error "Not yet implemented: postTableR"


getPopulateR :: Handler Text
getPopulateR = do
    -- Clear existing tables, menu items and orders
    runDB $ deleteWhere ([] :: [Filter Table])
    runDB $ deleteWhere ([] :: [Filter Item])
    runDB $ deleteWhere ([] :: [Filter Order])

    -- Populate
    runDB $ forM tables insert
    runDB $ forM items insert
    return "Populated"

    where
        tables :: [Table]
        tables = replicate 10 Table

        items :: [Item]
        items =
            [ Item
                "Churrasco"
                "Carne de res, arroz, porción de papas, huevo frito y ensalada."
                4.0 Main

            , Item
                "Alitas a la barbiquiu"
                "Alitas bañadas en salsa barbiquiu, porción de papas y ensalada."
                3.75 Main

            , Item
                "Pollo al horno con papas"
                "Pollo, porción de papas, ensalada y aderezo de salsas."
                3.50 Main

            , Item
                "Pescado frito con papas"
                "Filete de pescado, porción de papas, ensalada y aderezo de salsas."
                4.50 Main

            , Item
                "Lasaña"
                "Porción de lasaña con ensalada"
                3.00 Main

            , Item
                "Parrillada"
                "Carne de res, pollo, carne de cerdo, porción de papas fritas, papas cocidas y ensalada."
                10.00 Main

            , Item
                "Chaulafán"
                "Chaulafán con camarón."
                3.00 Main

            , Item
                "Lomo a la plancha"
                "Lomo de res, ensalada y aderezo de salsas."
                4.00 Main

            , Item
                "Cangrejada"
                "Cangrejo, ensalada, guacamole, porción de chifles y aderezo de salsas."
                7.00 Main

            , Item
                "Cuy con papas"
                "Cuy, porción de papas cocidas, porción de arroz, mote, huevo duro y ensalada."
                7.50 Main

            , Item
                "Ceviche de camarón"
                "Ceviche de camarón, porción de chifles y canguil."
                5.00 Main

            , Item
                "Porción  tres leches"
                "Porción bañado en tres leches con aderezos."
                3.50 Dessert

            , Item
                "Brownie de chocolate"
                "Brownie con nueces bañado en chocolate."
                2.50 Dessert

            , Item
                "Crepes con nutella"
                "Crepes rellenas con nutella y durazno."
                2.00 Dessert

            , Item
                "Brochetas de frutas con chocolate"
                "Brochetas de guineo, frutilla,uvas,kiwi y manzana bañadas en chocolate."
                3.50 Dessert

            , Item
                "Porción de torta con helado"
                "Porción de torta bañada en chocolate y helado a su gusto(mora, vainilla, chocolate, chicle)"
                4.00 Dessert

            , Item
                "Cheesecake de mora"
                "Cheesecake con chispas de mora."
                6.00 Dessert

            , Item
                "Capuchino"
                ""
                2.00 Drink

            , Item
                "Cóctel"
                ""
                2.50 Drink

            , Item
                "Café Express"
                ""
                1.50 Drink

            , Item
                "Jugos naturales"
                "Jugos sabor a mora, naranja y guanábana."
                1.00 Drink
            ]
