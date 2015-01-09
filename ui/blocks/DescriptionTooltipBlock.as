package blocks
{
    import d2hooks.*;

    public class DescriptionTooltipBlock 
    {

        private var _description:String;
        private var _content:String;
        private var _block:Object;

        public function DescriptionTooltipBlock(description:String)
        {
            this._description = description;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("description", "chunks/description/description.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("description").processContent({"description":this._description});
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

