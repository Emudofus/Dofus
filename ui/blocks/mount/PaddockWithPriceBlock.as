package blocks.mount
{
    import d2hooks.*;

    public class PaddockWithPriceBlock 
    {

        private var _content:String;
        private var _infos:Object;
        private var _block:Object;

        public function PaddockWithPriceBlock(infos:Object)
        {
            this._infos = infos;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/mount/paddockWithPrice.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("content").processContent(this._infos);
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
}//package blocks.mount

