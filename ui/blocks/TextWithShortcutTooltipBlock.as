package blocks
{
    import d2hooks.*;

    public class TextWithShortcutTooltipBlock 
    {

        private var _content:String;
        private var _param:Object;
        private var _block:Object;

        public function TextWithShortcutTooltipBlock(txt:String, param:Object=null)
        {
            if (param == null)
            {
                this._param = {"css":"[local.css]tooltip_title.css"};
            }
            else
            {
                this._param = param;
            };
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            if (this._param.width)
            {
                this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/text/fixedContentWithShortcut.txt")]);
            }
            else
            {
                if (this._param.nameless)
                {
                    this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/text/namelessContentWithShortcut.txt")]);
                }
                else
                {
                    this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/text/contentWithShortcut.txt")]);
                };
            };
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("content").processContent(this._param);
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

