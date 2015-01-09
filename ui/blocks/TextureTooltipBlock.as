package blocks
{
    import d2hooks.*;

    public class TextureTooltipBlock 
    {

        private var _content:String;
        private var _block:Object;
        private var _uri:String;

        public function TextureTooltipBlock(uri:String)
        {
            this._uri = uri;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/texture/content.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("content").processContent({"uri":this._uri});
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

