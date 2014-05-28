package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import flash.utils.IDataInput;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.types.uiDefinition.UiDefinition;
   import flash.utils.IDataOutput;
   import flash.net.ObjectEncoding;
   
   public class PreCompiledUiModule extends UiModule implements IModuleUtil
   {
      
      public function PreCompiledUiModule() {
         super();
      }
      
      private static const HEADER_STR:String = "D2UI";
      
      public static function fromRaw(input:IDataInput, nativePath:String, id:String) : PreCompiledUiModule {
         var instance:PreCompiledUiModule = new PreCompiledUiModule();
         var localInput:ByteArray = new ByteArray();
         instance._input = localInput;
         input.readBytes(localInput);
         localInput.position = 0;
         var headerStr:String = localInput.readUTF();
         if(headerStr != HEADER_STR)
         {
            throw new Error("Malformated ui data file.");
         }
         else
         {
            instance.fillFromXml(new XML(localInput.readUTF()),nativePath,id);
            instance._definitionCount = localInput.readShort();
            instance._uiListPosition = new Dictionary();
            instance._cacheDefinition = new Dictionary();
            i = 0;
            while(i < instance._definitionCount)
            {
               instance._uiListPosition[localInput.readUTF()] = localInput.readInt();
               i++;
            }
            return instance;
         }
      }
      
      public static function create(uiModule:UiModule) : PreCompiledUiModule {
         var newInstance:PreCompiledUiModule = new PreCompiledUiModule();
         newInstance.initWriteMode();
         newInstance.makeHeader(uiModule);
         return newInstance;
      }
      
      private var _uiListPosition:Dictionary;
      
      private var _definitionCount:uint;
      
      private var _uiListStartPosition:uint;
      
      private var _output:ByteArray;
      
      private var _uiBuffer:ByteArray;
      
      private var _input:ByteArray;
      
      private var _cacheDefinition:Dictionary;
      
      public function hasDefinition(ui:UiData) : Boolean {
         return !(this._uiListPosition[ui.name] == null);
      }
      
      public function getDefinition(ui:UiData) : UiDefinition {
         if(this.hasDefinition(ui))
         {
            if(this._cacheDefinition[ui.name])
            {
               return this._cacheDefinition[ui.name];
            }
            return this.readUidefinition(ui.name);
         }
         return null;
      }
      
      public function addUiDefinition(definition:UiDefinition, ui:UiData) : void {
         if(!this._output)
         {
            throw new Error("Call method \'create\' before using this method");
         }
         else
         {
            this.writeUiDefinition(definition,ui);
            return;
         }
      }
      
      public function flush(output:IDataOutput) : void {
         var uiId:String = null;
         if(!this._output)
         {
            throw new Error("Call method \'create\' before using this method");
         }
         else
         {
            this._output.position = this._uiListStartPosition;
            this._output.writeShort(this._definitionCount);
            output.writeBytes(this._output);
            this._output.position = this._output.length;
            listBuffer = new ByteArray();
            for(uiId in this._uiListPosition)
            {
               listBuffer.writeUTF(uiId);
               listBuffer.writeInt(0);
            }
            listBuffer.position = 0;
            for(uiId in this._uiListPosition)
            {
               listBuffer.readUTF();
               listBuffer.writeInt(this._uiListPosition[uiId] + this._output.length + listBuffer.length);
            }
            output.writeBytes(listBuffer);
            output.writeBytes(this._uiBuffer);
            return;
         }
      }
      
      private function initWriteMode() : void {
         this._output = new ByteArray();
         this._uiBuffer = new ByteArray();
         this._uiListPosition = new Dictionary();
         this._uiBuffer.objectEncoding = ObjectEncoding.AMF3;
      }
      
      private function makeHeader(uiModule:UiModule) : void {
         this._output.writeUTF("D2UI");
         this._output.writeUTF(uiModule.rawXml.toXMLString());
         this._uiListStartPosition = this._output.position;
         this._output.writeShort(0);
      }
      
      private function readUidefinition(id:String) : UiDefinition {
         this._input.objectEncoding = ObjectEncoding.AMF3;
         this._input.position = this._uiListPosition[id];
         return this._input.readObject();
      }
      
      private function writeUiDefinition(definition:UiDefinition, ui:UiData) : void {
         this._definitionCount++;
         this._uiListPosition[ui.name] = this._uiBuffer.position;
         this._uiBuffer.objectEncoding = ObjectEncoding.AMF3;
         this._uiBuffer.writeObject(definition);
      }
   }
}
