package flashx.textLayout.conversion
{
   import flashx.textLayout.elements.IConfiguration;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.FlowLeafElement;
   
   class PlainTextImporter extends ConverterBase implements ITextImporter
   {
      
      function PlainTextImporter() {
         super();
      }
      
      private static const _newLineRegex:RegExp = new RegExp("\n|\r\n?","g");
      
      protected var _config:IConfiguration = null;
      
      public function importToFlow(param1:Object) : TextFlow {
         if(param1 is String)
         {
            return this.importFromString(String(param1));
         }
         return null;
      }
      
      public function get configuration() : IConfiguration {
         return this._config;
      }
      
      public function set configuration(param1:IConfiguration) : void {
         this._config = param1;
      }
      
      protected function importFromString(param1:String) : TextFlow {
         var _loc4_:String = null;
         var _loc5_:ParagraphElement = null;
         var _loc6_:SpanElement = null;
         var _loc7_:FlowLeafElement = null;
         var _loc2_:Array = param1.split(_newLineRegex);
         var _loc3_:TextFlow = new TextFlow(this._config);
         for each (_loc4_ in _loc2_)
         {
            _loc5_ = new ParagraphElement();
            _loc6_ = new SpanElement();
            _loc6_.replaceText(0,0,_loc4_);
            _loc5_.replaceChildren(0,0,_loc6_);
            _loc3_.replaceChildren(_loc3_.numChildren,_loc3_.numChildren,_loc5_);
         }
         if((useClipboardAnnotations) && (param1.lastIndexOf("\n",param1.length - 2) < 0 || param1.lastIndexOf("\r\n",param1.length - 3) < 0))
         {
            _loc7_ = _loc3_.getLastLeaf();
            _loc7_.setStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE,"true");
            _loc7_.parent.setStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE,"true");
            _loc3_.setStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE,"true");
         }
         return _loc3_;
      }
   }
}
