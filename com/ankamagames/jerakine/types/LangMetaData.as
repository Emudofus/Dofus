package com.ankamagames.jerakine.types
{
   import com.ankamagames.jerakine.utils.files.FileUtils;
   
   public class LangMetaData extends Object
   {
      
      public function LangMetaData() {
         this.clearFile = new Array();
         super();
      }
      
      public static function fromXml(sXml:String, sUrlProvider:String, checkFunction:Function) : LangMetaData {
         var file:XML = null;
         var xml:XML = new XML(sXml);
         var metaData:LangMetaData = new LangMetaData();
         var bHaveVersionData:Boolean = false;
         if(xml..filesActions..clearOnlyNotUpToDate.toString() == "true")
         {
            metaData.clearOnlyNotUpToDate = true;
         }
         if(xml..filesActions..clearOnlyNotUpToDate.toString() == "false")
         {
            metaData.clearOnlyNotUpToDate = false;
         }
         if(xml..filesActions..loadAllFile.toString() == "true")
         {
            metaData.loadAllFile = true;
         }
         if(xml..filesActions..loadAllFile.toString() == "false")
         {
            metaData.loadAllFile = false;
         }
         if(xml..filesActions..clearAllFile.toString() == "true")
         {
            metaData.clearAllFile = true;
         }
         if(xml..filesActions..clearAllFile.toString() == "false")
         {
            metaData.clearAllFile = false;
         }
         for each (file in xml..filesVersions..file)
         {
            bHaveVersionData = true;
            if((metaData.clearAllFile) || (!metaData.clearOnlyNotUpToDate) || (!checkFunction(FileUtils.getFileStartName(sUrlProvider) + "." + file..@name,file.toString())))
            {
               metaData.addFile(file..@name,file.toString());
            }
         }
         if(!bHaveVersionData)
         {
            metaData.loadAllFile = true;
         }
         return metaData;
      }
      
      private var _nFileCount:uint = 0;
      
      public var loadAllFile:Boolean = false;
      
      public var clearAllFile:Boolean = false;
      
      public var clearOnlyNotUpToDate:Boolean = true;
      
      public var clearFile:Array;
      
      public function addFile(sFilename:String, sVersion:String) : void {
         this._nFileCount++;
         this.clearFile[sFilename] = sVersion;
      }
      
      public function get clearFileCount() : uint {
         return this._nFileCount;
      }
   }
}
