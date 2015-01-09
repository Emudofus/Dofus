package blocks
{
    import d2hooks.*;

    public class CraftSmileyTooltipBlock 
    {

        private var _content:String;
        private var _block:Object;
        private var _iconId:int;
        private var _craftResult:uint;

        public function CraftSmileyTooltipBlock(craftSmileyItem:Object)
        {
            this._iconId = craftSmileyItem.iconId;
            this._craftResult = craftSmileyItem.craftResult;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/craftSmiley/content.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            var uri:String;
            var backgroundName:String;
            var crossVisible:Boolean;
            var oVisible:Boolean = true;
            switch (this._craftResult)
            {
                case 0:
                    backgroundName = "Craft_tx_bulleRouge";
                    crossVisible = true;
                    break;
                case 1:
                    backgroundName = "Craft_tx_bulleRouge";
                    break;
                case 2:
                    backgroundName = "Craft_tx_bulle";
                    break;
            };
            if (this._iconId == 0)
            {
                uri = "[config.ui.skin]assets.swf|inventaire_tx_kama";
            }
            else
            {
                uri = (("[config.gfx.path.item.bitmap]" + this._iconId) + ".png");
            };
            if (this._iconId == -1)
            {
                oVisible = false;
            };
            this._content = this._block.getChunk("content").processContent({
                "uri":uri,
                "backName":backgroundName,
                "xVisible":crossVisible,
                "oVisible":oVisible
            });
        }

        public function getContent():String
        {
            return (this._content);
        }

        public function get block():Object
        {
            return (this._block);
        }


    }
}//package blocks

