package 
{
   import flash.display.Sprite;
   import ui.ReadingBook;
   import ui.Scroll;
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DocumentApi;
   import d2hooks.DocumentReadingBegin;
   
   public class Document extends Sprite
   {
      
      public function Document() {
         super();
      }
      
      private static const TYPE_BOOK:uint = 1;
      
      private static const TYPE_SCROLL:uint = 2;
      
      protected var readingBook:ReadingBook;
      
      protected var scroll:Scroll;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var docApi:DocumentApi;
      
      public var modCommon:Object;
      
      public function main() : void {
         this.sysApi.addHook(DocumentReadingBegin,this.onDocumentReadingBegin);
      }
      
      private function onDocumentReadingBegin(documentId:uint) : void {
         var typeId:uint = this.docApi.getType(documentId);
         switch(typeId)
         {
            case TYPE_BOOK:
               if(!this.uiApi.getUi("readingBook"))
               {
                  this.uiApi.loadUi("readingBook","readingBook",{"documentId":documentId});
               }
               break;
            case TYPE_SCROLL:
               if(!this.uiApi.getUi("scroll"))
               {
                  this.uiApi.loadUi("scroll","scroll",{"documentId":documentId});
               }
               break;
         }
      }
   }
}
