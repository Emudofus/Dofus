package com.ankamagames.jerakine.task
{
   import com.ankamagames.jerakine.tasking.SplittedTask;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.LangFile;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import com.ankamagames.jerakine.types.events.LangFileEvent;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.JerakineConstants;
   
   public class LangXmlParsingTask extends SplittedTask
   {
      
      public function LangXmlParsingTask(param1:Array, param2:String, param3:Boolean=true) {
         super();
         this._nCurrentIndex = 0;
         this._aFiles = param1;
         this._sUrlProvider = param2;
         this._parseReference = param3;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LangXmlParsingTask));
      
      private var _nCurrentIndex:uint;
      
      private var _aFiles:Array;
      
      private var _sUrlProvider:String;
      
      private var _parseReference:Boolean;
      
      override public function step() : Boolean {
         var _loc1_:LangFile = null;
         if(this._aFiles.length)
         {
            _loc1_ = LangFile(this._aFiles.shift());
            this.parseXml(_loc1_.content,_loc1_.category);
            if((_loc1_.metaData) && (_loc1_.metaData.clearFile[_loc1_.url]))
            {
               LangManager.getInstance().setFileVersion(FileUtils.getFileStartName(this._sUrlProvider) + "." + _loc1_.url,_loc1_.metaData.clearFile[_loc1_.url]);
            }
            dispatchEvent(new LangFileEvent(LangFileEvent.COMPLETE,false,false,_loc1_.url,this._sUrlProvider));
         }
         if(!this._aFiles.length)
         {
            dispatchEvent(new LangFileEvent(LangFileEvent.ALL_COMPLETE,false,false,this._sUrlProvider,this._sUrlProvider));
         }
         return !this._aFiles.length;
      }
      
      public function parseForReg() : Boolean {
         var _loc1_:LangFile = null;
         if(this._aFiles.length)
         {
            _loc1_ = LangFile(this._aFiles.shift());
            this.parseXml(_loc1_.content,_loc1_.category);
            if((_loc1_.metaData) && (_loc1_.metaData.clearFile[_loc1_.url]))
            {
               LangManager.getInstance().setFileVersion(FileUtils.getFileStartName(this._sUrlProvider) + "." + _loc1_.url,_loc1_.metaData.clearFile[_loc1_.url]);
            }
            dispatchEvent(new LangFileEvent(LangFileEvent.COMPLETE,false,false,_loc1_.url,this._sUrlProvider));
         }
         return !this._aFiles.length;
      }
      
      override public function stepsPerFrame() : uint {
         return 1;
      }
      
      private function parseXml(param1:String, param2:String) : void {
         var xml:XML = null;
         var sEntry:String = null;
         var entry:XML = null;
         var sXml:String = param1;
         var sCategory:String = param2;
         try
         {
            xml = new XML(sXml);
            LangManager.getInstance().category[sCategory] = true;
            StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_LANG,"langCategory",LangManager.getInstance().category);
            for each (entry in xml..entry)
            {
               if(this._parseReference)
               {
                  sEntry = LangManager.getInstance().replaceKey(entry.toString());
               }
               else
               {
                  sEntry = entry.toString();
               }
               LangManager.getInstance().setEntry(sCategory + "." + entry..@key,sEntry,entry..@type.toString().length?entry..@type:null);
            }
         }
         catch(e:TypeError)
         {
            _log.error("Parsing error on category " + sCategory);
         }
      }
   }
}
