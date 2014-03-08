package com.ankamagames.jerakine.types
{
   import com.ankamagames.jerakine.utils.files.FileUtils;
   
   public class LangMetaData extends Object
   {
      
      public function LangMetaData() {
         this.clearFile = new Array();
         super();
      }
      
      public static function fromXml(param1:String, param2:String, param3:Function) : LangMetaData {
         var _loc7_:XML = null;
         var _loc4_:XML = new XML(param1);
         var _loc5_:LangMetaData = new LangMetaData();
         var _loc6_:* = false;
         if(_loc4_..filesActions..clearOnlyNotUpToDate.toString() == "true")
         {
            _loc5_.clearOnlyNotUpToDate = true;
         }
         if(_loc4_..filesActions..clearOnlyNotUpToDate.toString() == "false")
         {
            _loc5_.clearOnlyNotUpToDate = false;
         }
         if(_loc4_..filesActions..loadAllFile.toString() == "true")
         {
            _loc5_.loadAllFile = true;
         }
         if(_loc4_..filesActions..loadAllFile.toString() == "false")
         {
            _loc5_.loadAllFile = false;
         }
         if(_loc4_..filesActions..clearAllFile.toString() == "true")
         {
            _loc5_.clearAllFile = true;
         }
         if(_loc4_..filesActions..clearAllFile.toString() == "false")
         {
            _loc5_.clearAllFile = false;
         }
         for each (_loc7_ in _loc4_..filesVersions..file)
         {
            _loc6_ = true;
            if((_loc5_.clearAllFile) || !_loc5_.clearOnlyNotUpToDate || !param3(FileUtils.getFileStartName(param2) + "." + _loc7_..@name,_loc7_.toString()))
            {
               _loc5_.addFile(_loc7_..@name,_loc7_.toString());
            }
         }
         if(!_loc6_)
         {
            _loc5_.loadAllFile = true;
         }
         return _loc5_;
      }
      
      private var _nFileCount:uint = 0;
      
      public var loadAllFile:Boolean = false;
      
      public var clearAllFile:Boolean = false;
      
      public var clearOnlyNotUpToDate:Boolean = true;
      
      public var clearFile:Array;
      
      public function addFile(param1:String, param2:String) : void {
         this._nFileCount++;
         this.clearFile[param1] = param2;
      }
      
      public function get clearFileCount() : uint {
         return this._nFileCount;
      }
   }
}
