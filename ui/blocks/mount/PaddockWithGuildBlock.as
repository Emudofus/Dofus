package blocks.mount
{
   import d2hooks.*;
   
   public class PaddockWithGuildBlock extends Object
   {
      
      public function PaddockWithGuildBlock(infos:Object) {
         super();
         this._infos = infos;
         this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,this.getContent);
         this._block.initChunk([Api.tooltip.createChunkData("content","chunks/mount/paddockWithGuild.txt")]);
      }
      
      private var _content:String;
      
      private var _infos:Object;
      
      private var _block:Object;
      
      public function onAllChunkLoaded() : void {
         this._content = this._block.getChunk("content").processContent(this._infos);
      }
      
      public function getContent() : String {
         return this._content;
      }
      
      public function get block() : Object {
         return this._block;
      }
   }
}
