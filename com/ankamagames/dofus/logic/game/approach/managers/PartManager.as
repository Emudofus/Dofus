package com.ankamagames.dofus.logic.game.approach.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.messages.updater.parts.GetPartsListMessage;
   import com.ankamagames.dofus.kernel.updater.UpdaterConnexionHandler;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.updater.ContentPart;
   import com.ankamagames.dofus.network.enums.PartStateEnum;
   import com.ankamagames.dofus.logic.game.approach.utils.DownloadMonitoring;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.datacenter.misc.Pack;
   import com.ankamagames.dofus.network.messages.updater.parts.DownloadPartMessage;


   public class PartManager extends Object
   {
         

      public function PartManager() {
         this._downloadList=new Array();
         super();
         DownloadMonitoring.getInstance().initialize();
      }

      public static const STATE_WAITING:int = 0;

      public static const STATE_DOWNLOADING:int = 1;

      public static const STATE_FINISHED:int = 2;

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PartManager));

      private static var _singleton:PartManager;

      public static function getInstance() : PartManager {
         if(!_singleton)
         {
            _singleton=new PartManager();
         }
         return _singleton;
      }

      private var _parts:Dictionary = null;

      private var _firstParts:Dictionary = null;

      private var _downloadList:Array;

      private var _downloadingPart:String = null;

      private var _downloadCount:int = 0;

      private var _downloadSuccess:int = 0;

      private var _state:int = 0;

      public function initialize() : void {
         var gplmsg:GetPartsListMessage = new GetPartsListMessage();
         gplmsg.initGetPartsListMessage();
         UpdaterConnexionHandler.getConnection().send(gplmsg);
      }

      public function receiveParts(parts:Vector.<ContentPart>) : void {
         var part:ContentPart = null;
         var key:String = null;
         this._parts=new Dictionary();
         for each (part in parts)
         {
            this.updatePart(part);
         }
         if(!this._firstParts)
         {
            this._firstParts=new Dictionary();
            for (key in this._parts)
            {
               this._firstParts[key]=this._parts[key];
            }
         }
      }

      public function checkAndDownload(partName:String) : void {
         var part:String = null;
         if(!this._parts)
         {
            _log.warn("checkAndDownload \'"+partName+"\' but can\'t got part list (updater is down ?)");
            return;
         }
         if(!this._parts.hasOwnProperty(partName))
         {
            _log.error("Unknow part id : "+partName);
            return;
         }
         if(this._parts[partName].state==PartStateEnum.PART_NOT_INSTALLED)
         {
            for each (part in this._downloadList)
            {
               if(part==partName)
               {
                  return;
               }
            }
            this._downloadCount++;
            this.download(partName);
         }
      }

      public function updatePart(part:ContentPart) : void {
         var isDownloading:* = false;
         var p:ContentPart = null;
         var partName:String = null;
         if(!this._parts)
         {
            _log.error("updatePart \'"+part.id+"\' but can\'t got part liste (updater is down ?)");
            return;
         }
         var oldPart:ContentPart = this._parts[part.id];
         this._parts[part.id]=part;
         switch(part.state)
         {
            case PartStateEnum.PART_BEING_UPDATER:
               DownloadMonitoring.getInstance().start();
               if(part.id!=this._downloadingPart)
               {
                  if(this._downloadingPart)
                  {
                     _log.error("On reçoit des informations de téléchargement d\'une partie de contenu "+part.id+", alors qu\'on a pour demande de récupérer "+this._downloadingPart+". Ce téléchargement risque de provoquer un conflit (téléchargements simultanés");
                  }
                  else
                  {
                     this._downloadingPart=part.id;
                  }
               }
               break;
            case PartStateEnum.PART_UP_TO_DATE:
               if(part.id==this._downloadingPart)
               {
                  isDownloading=false;
                  for each (p in this._parts)
                  {
                     if(p.state==PartStateEnum.PART_BEING_UPDATER)
                     {
                        isDownloading=true;
                        _log.error(p.id+" en cours de téléchargement alors qu\'une autre part vient juste de se terminer...");
                        throw new Error(p.id+" en cours de téléchargement alors qu\'une autre part vient juste de se terminer...");
                     }
                     else
                     {
                        continue;
                     }
                  }
                  if(!isDownloading)
                  {
                     this._downloadSuccess++;
                     _log.info("Updater download is terminated.");
                     this._downloadingPart=null;
                     if(this._downloadList.length==0)
                     {
                        DownloadMonitoring.getInstance().stop();
                        this._state=STATE_FINISHED;
                        KernelEventsManager.getInstance().processCallback(HookList.AllDownloadTerminated);
                     }
                     else
                     {
                        partName=this._downloadList.pop();
                        _log.info(partName+" found in download queue");
                        this.download(partName);
                     }
                  }
               }
               break;
         }
      }

      public function getServerPartList() : Vector.<uint> {
         var pack:Pack = null;
         var found:* = false;
         var part:ContentPart = null;
         if(this._firstParts==null)
         {
            return null;
         }
         var count:uint = 0;
         var packs:Array = Pack.getAllPacks();
         var list:Vector.<uint> = new Vector.<uint>();
         for each (pack in packs)
         {
            if(pack.hasSubAreas)
            {
               count++;
               found=false;
               for each (part in this._firstParts)
               {
                  if((part.id==pack.name)&&(part.state==2))
                  {
                     found=true;
                     break;
                  }
               }
               if(found)
               {
                  list.push(pack.id);
               }
            }
         }
         if(list.length==count)
         {
            return null;
         }
         return list;
      }

      public function getPart(partName:String) : ContentPart {
         var part:ContentPart = null;
         for each (part in this._parts)
         {
            if(part.id==partName)
            {
               return part;
            }
         }
         return null;
      }

      public function createEmptyPartList() : void {
         this._parts=new Dictionary();
      }

      public function getDownloadPercent(base:int) : int {
         var percent:int = 100*this._downloadSuccess/this._downloadCount+base/this._downloadCount;
         if(percent<0)
         {
            return 0;
         }
         if(percent>100)
         {
            return 100;
         }
         return percent;
      }

      public function get isDownloading() : Boolean {
         return this._state==STATE_DOWNLOADING;
      }

      public function get isFinished() : Boolean {
         return this._state==STATE_FINISHED;
      }

      private function download(partName:String) : void {
         var dpmsg:DownloadPartMessage = null;
         this._state=STATE_DOWNLOADING;
         if(this._parts[partName].state==PartStateEnum.PART_NOT_INSTALLED)
         {
            if(!this._downloadingPart)
            {
               _log.info("Send download request for "+partName+" to updater");
               dpmsg=new DownloadPartMessage();
               dpmsg.initDownloadPartMessage(partName);
               UpdaterConnexionHandler.getConnection().send(dpmsg);
               this._downloadingPart=partName;
            }
            else
            {
               if(this._downloadList.indexOf(partName)==-1)
               {
                  _log.info("A download is running. Add "+partName+" to download queue");
                  this._downloadList.push(partName);
               }
            }
         }
      }
   }

}