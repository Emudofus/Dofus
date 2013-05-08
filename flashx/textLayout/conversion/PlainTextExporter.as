package flashx.textLayout.conversion
{
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.FlowLeafElement;

   use namespace tlf_internal;

   public class PlainTextExporter extends ConverterBase implements IPlainTextExporter
   {
         

      public function PlainTextExporter() {
         super();
         this._stripDiscretionaryHyphens=true;
         this._paragraphSeparator="\n";
      }

      private static var _discretionaryHyphen:String = String.fromCharCode(173);

      private var _stripDiscretionaryHyphens:Boolean;

      private var _paragraphSeparator:String;

      public function get stripDiscretionaryHyphens() : Boolean {
         return this._stripDiscretionaryHyphens;
      }

      public function set stripDiscretionaryHyphens(value:Boolean) : void {
         this._stripDiscretionaryHyphens=value;
      }

      public function get paragraphSeparator() : String {
         return this._paragraphSeparator;
      }

      public function set paragraphSeparator(value:String) : void {
         this._paragraphSeparator=value;
      }

      public function export(source:TextFlow, conversionType:String) : Object {
         clear();
         if(conversionType==ConversionType.STRING_TYPE)
         {
            return this.exportToString(source);
         }
         return null;
      }

      protected function exportToString(source:TextFlow) : String {
         var p:ParagraphElement = null;
         var curString:String = null;
         var nextLeaf:FlowLeafElement = null;
         var temparray:Array = null;
         var lastPara:ParagraphElement = null;
         var rslt:String = "";
         var leaf:FlowLeafElement = source.getFirstLeaf();
         loop0:
         while(leaf)
         {
            p=leaf.getParagraph();
            do
            {
               curString=leaf.text;
               if(this._stripDiscretionaryHyphens)
               {
                  temparray=curString.split(_discretionaryHyphen);
                  curString=temparray.join("");
               }
               rslt=rslt+curString;
               nextLeaf=leaf.getNextLeaf(p);
               if(!nextLeaf)
               {
                  leaf=leaf.getNextLeaf();
                  if(leaf)
                  {
                     rslt=rslt+this._paragraphSeparator;
                  }
                  continue loop0;
               }
               leaf=nextLeaf;
            }
            while(true);
         }
         if(useClipboardAnnotations)
         {
            lastPara=source.getLastLeaf().getParagraph();
            if(lastPara.getStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE)!="true")
            {
               rslt=rslt+this._paragraphSeparator;
            }
         }
         return rslt;
      }
   }

}