package flashx.textLayout.conversion
{
   public class FormatDescriptor extends Object
   {
      
      public function FormatDescriptor(param1:String, param2:Class, param3:Class, param4:String) {
         super();
         this._format = param1;
         this._clipboardFormat = param4;
         this._importerClass = param2;
         this._exporterClass = param3;
      }
      
      private var _format:String;
      
      private var _clipboardFormat:String;
      
      private var _importerClass:Class;
      
      private var _exporterClass:Class;
      
      public function get format() : String {
         return this._format;
      }
      
      public function get clipboardFormat() : String {
         return this._clipboardFormat;
      }
      
      public function get importerClass() : Class {
         return this._importerClass;
      }
      
      public function get exporterClass() : Class {
         return this._exporterClass;
      }
   }
}
