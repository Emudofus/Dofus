package blocks
{
   import d2hooks.*;
   
   public class WorldRpMonstersAgeBonusBlock extends Object
   {
      
      public function WorldRpMonstersAgeBonusBlock() {
         super();
         this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,this.getContent);
         this._block.initChunk([Api.tooltip.createChunkData("content","chunks/world/rpMonstersAgeBonus.txt")]);
      }
      
      private static var _infos:Object;
      
      private var _content:String;
      
      private var _block:Object;
      
      public function onAllChunkLoaded() : void {
         this._content = this._block.getChunk("content").processContent(_infos);
      }
      
      public function getContent() : String {
         return this._content;
      }
      
      public function get block() : Object {
         return this._block;
      }
   }
}
