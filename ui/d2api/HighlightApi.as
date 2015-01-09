package d2api
{
    public class HighlightApi 
    {


        [Untrusted]
        public function forceArrowPosition(pUiName:String, pComponentName:String, pPosition:Object):void
        {
        }

        [Untrusted]
        public function highlightUi(uiName:String, componentName:String, pos:int=0, reverse:int=0, strata:int=5, loop:Boolean=false):void
        {
        }

        [Untrusted]
        public function highlightCell(cellIds:Object, loop:Boolean=false):void
        {
        }

        [Untrusted]
        public function highlightAbsolute(targetRect:Object, pos:uint, reverse:int=0, strata:int=5, loop:Boolean=false):void
        {
        }

        [Untrusted]
        public function highlightMapTransition(mapId:int, shapeOrientation:int, position:int, reverse:Boolean=false, strata:int=5, loop:Boolean=false):void
        {
        }

        [Untrusted]
        public function highlightNpc(npcId:int, loop:Boolean=false):void
        {
        }

        [Untrusted]
        public function highlightMonster(monsterId:int, loop:Boolean=false):void
        {
        }

        [Untrusted]
        public function stop():void
        {
        }


    }
}//package d2api

