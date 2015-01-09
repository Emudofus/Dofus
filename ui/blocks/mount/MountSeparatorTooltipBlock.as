package blocks.mount
{
    import d2hooks.*;

    public class MountSeparatorTooltipBlock 
    {

        private var _content:String;
        private var _block:Object;

        public function MountSeparatorTooltipBlock()
        {
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("separator", "chunks/mount/separator.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("separator").processContent(new Object());
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

