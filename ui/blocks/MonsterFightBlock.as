package blocks
{
    import d2hooks.*;

    public class MonsterFightBlock 
    {

        private var _content:String;
        private var _block:Object;

        public function MonsterFightBlock()
        {
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/world/monsterFight.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("content").content;
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

