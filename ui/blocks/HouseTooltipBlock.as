package blocks
{
   import d2hooks.*;
   
   public class HouseTooltipBlock extends Object
   {
      
      public function HouseTooltipBlock(infos:Object, type:int) {
         super();
         this._infos = infos;
         this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,this.getContent);
         if(type == 0)
         {
            this._block.initChunk([Api.tooltip.createChunkData("content","chunks/world/house/house.txt")]);
         }
         else if(type == 1)
         {
            this._block.initChunk([Api.tooltip.createChunkData("content","chunks/world/house/housePrice.txt")]);
         }
         else if(type == 2)
         {
            this._block.initChunk([Api.tooltip.createChunkData("content","chunks/world/house/houseGuild.txt")]);
         }
         else if(type == 3)
         {
            this._block.initChunk([Api.tooltip.createChunkData("content","chunks/world/house/housePriceLocked.txt")]);
         }
         
         
         
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
