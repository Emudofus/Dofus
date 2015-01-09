package blocks
{
    import d2hooks.*;

    public class ThinkTooltipBlock 
    {

        private var _content:String;
        private var _msg:String;
        private var _block:Object;

        public function ThinkTooltipBlock(msg:String)
        {
            msg = Api.chat.unEscapeChatString(msg);
            msg = Api.chat.getStaticHyperlink(msg);
            this._msg = msg;
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            this._block.initChunk([Api.tooltip.createChunkData("content", "chunks/tchat/think.txt")]);
        }

        public function onAllChunkLoaded():void
        {
            this._content = this._block.getChunk("content").processContent({"msg":this._msg});
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

