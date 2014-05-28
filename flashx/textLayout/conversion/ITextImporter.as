package flashx.textLayout.conversion
{
   import flashx.textLayout.elements.TextFlow;
   import __AS3__.vec.Vector;
   import flashx.textLayout.elements.IConfiguration;
   
   public interface ITextImporter
   {
      
      function importToFlow(param1:Object) : TextFlow;
      
      function get errors() : Vector.<String>;
      
      function get throwOnError() : Boolean;
      
      function set throwOnError(param1:Boolean) : void;
      
      function get useClipboardAnnotations() : Boolean;
      
      function set useClipboardAnnotations(param1:Boolean) : void;
      
      function get configuration() : IConfiguration;
      
      function set configuration(param1:IConfiguration) : void;
   }
}
