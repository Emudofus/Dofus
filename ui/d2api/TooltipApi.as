package d2api
{
    import d2data.SpellWrapper;
    import d2data.ItemWrapper;
    import d2utils.TooltipRectangle;
    import d2utils.SpellTooltipSettings;
    import d2utils.ItemTooltipSettings;

    public class TooltipApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function setDefaultTooltipUiScript(module:String, ui:String):void
        {
        }

        [Untrusted]
        public function createTooltip(baseUri:String, containerUri:String, separatorUri:String=null):Object
        {
            return (null);
        }

        [Untrusted]
        public function createTooltipBlock(onAllChunkLoadedCallback:Function, contentGetter:Function):Object
        {
            return (null);
        }

        [Untrusted]
        public function registerTooltipAssoc(targetClass:*, makerName:String):void
        {
        }

        [Untrusted]
        public function registerTooltipMaker(makerName:String, makerClass:Class, scriptClass:Class=null):void
        {
        }

        [Untrusted]
        public function createChunkData(name:String, uri:String):Object
        {
            return (null);
        }

        [Untrusted]
        public function place(target:*, point:uint=6, relativePoint:uint=0, offset:int=3, checkSuperposition:Boolean=false, cellId:int=-1, alwaysDisplayed:Boolean=true):void
        {
        }

        [Untrusted]
        public function placeArrow(target:*):Object
        {
            return (null);
        }

        [Untrusted]
        public function getSpellTooltipInfo(spellWrapper:SpellWrapper, shortcutKey:String=null):Object
        {
            return (null);
        }

        [Untrusted]
        public function getItemTooltipInfo(itemWrapper:ItemWrapper, shortcutKey:String=null):Object
        {
            return (null);
        }

        [Untrusted]
        public function getSpellTooltipCache():int
        {
            return (0);
        }

        [Untrusted]
        public function resetSpellTooltipCache():void
        {
        }

        [Untrusted]
        public function createTooltipRectangle(x:Number=0, y:Number=0, width:Number=0, height:Number=0):TooltipRectangle
        {
            return (null);
        }

        [Trusted]
        public function createSpellSettings():SpellTooltipSettings
        {
            return (null);
        }

        [Trusted]
        public function createItemSettings():ItemTooltipSettings
        {
            return (null);
        }

        [Untrusted]
        public function adjustTooltipPositions(tooltipNames:Object, sourceName:String, offset:int=0):void
        {
        }


    }
}//package d2api

