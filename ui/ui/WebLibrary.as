package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2api.DataApi;
    import d2components.Grid;
    import d2enums.ComponentHookList;
    import d2hooks.ComicsLibraryLoaded;
    import d2actions.GetComicsLibraryRequest;
    import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
    import d2enums.StrataEnum;

    public class WebLibrary 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        public var dataApi:DataApi;
        public var gd_books:Grid;


        public function main(oParam:Object=null):void
        {
            this.uiApi.addComponentHook(this.gd_books, ComponentHookList.ON_SELECT_ITEM);
            this.sysApi.addHook(ComicsLibraryLoaded, this.onComicsLibraryLoaded);
            var playerId:String = "nullUser";
            this.sysApi.sendAction(new GetComicsLibraryRequest(playerId));
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (selectMethod != GridItemSelectMethodEnum.AUTO)
            {
                this.uiApi.loadUi("webReader", "webReader", {
                    "remoteId":target.selectedItem.comicId,
                    "readerUrl":this.dataApi.getComicReaderUrl(target.selectedItem.comicId),
                    "language":target.selectedItem.language
                }, StrataEnum.STRATA_TOP);
            };
        }

        public function onComicsLibraryLoaded(pComics:Object):void
        {
            this.gd_books.dataProvider = pComics;
        }

        public function updateBook(data:*, components:*, selected:Boolean):void
        {
            if (data)
            {
                components.tx_cover.alpha = 1;
            }
            else
            {
                components.tx_cover.alpha = 0.1;
            };
        }


    }
}//package ui

