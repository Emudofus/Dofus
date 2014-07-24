package blocks
{
   import d2hooks.*;
   
   public class TextTooltipBlock extends Object
   {
      
      public function TextTooltipBlock(txt:String, param:Object = null) {
         super();
         if(param == null)
         {
            this._param = {"css":"[local.css]tooltip_default.css"};
         }
         else
         {
            this._param = param;
         }
         if(!this._param.classCss)
         {
            this._param.classCss = "left";
         }
         if(!this._param.css)
         {
            this._param.css = "[local.css]tooltip_default.css";
         }
         this._param.content = txt;
         this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,this.getContent);
         if(this._param.width)
         {
            this._block.initChunk([Api.tooltip.createChunkData("content","chunks/text/fixedContent.txt")]);
         }
         else if(this._param.nameless)
         {
            this._block.initChunk([Api.tooltip.createChunkData("content","chunks/text/namelessContent.txt")]);
         }
         else
         {
            this._block.initChunk([Api.tooltip.createChunkData("content","chunks/text/content.txt")]);
         }
         
      }
      
      private var _content:String;
      
      private var _param:Object;
      
      private var _block:Object;
      
      public function onAllChunkLoaded() : void {
         this._content = this._block.getChunk("content").processContent(this._param);
      }
      
      public function getContent() : String {
         return this._content;
      }
      
      public function get block() : Object {
         return this._block;
      }
   }
}
