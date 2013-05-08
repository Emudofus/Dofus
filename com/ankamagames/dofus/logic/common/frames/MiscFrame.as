package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.house.AccountHouseInformations;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.dofus.network.messages.security.CheckFileRequestMessage;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import com.ankamagames.dofus.network.messages.security.CheckFileMessage;
   import com.ankamagames.dofus.network.messages.game.approach.ServerOptionalFeaturesMessage;
   import com.ankamagames.dofus.network.messages.game.approach.ServerSettingsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.AccountHouseMessage;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import by.blooddy.crypto.MD5;
   import flash.filesystem.FileMode;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.types.enums.Priority;


   public class MiscFrame extends Object implements Frame
   {
         

      public function MiscFrame() {
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MiscFrame));

      private var _optionalAuthorizedFeatures:Array;

      private var _accountHouses:Vector.<AccountHouseInformations>;

      public function isOptionalFeatureActive(id:uint) : Boolean {
         if((this._optionalAuthorizedFeatures)&&(this._optionalAuthorizedFeatures.indexOf(id)<-1))
         {
            return true;
         }
         return false;
      }

      public function get accountHouses() : Vector.<AccountHouseInformations> {
         return this._accountHouses;
      }

      public function pushed() : Boolean {
         return true;
      }

      public function pulled() : Boolean {
         return true;
      }

      public function process(msg:Message) : Boolean {
         var mrcMsg:MouseRightClickMessage = null;
         var current:DisplayObject = null;
         var stage:Stage = null;
         var worldContainer:DisplayObjectContainer = null;
         var beriliaContainer:DisplayObjectContainer = null;
         var cfrmsg:CheckFileRequestMessage = null;
         var fileStream:FileStream = null;
         var fileByte:ByteArray = null;
         var value:String = null;
         var filenameHash:String = null;
         var cfmsg:CheckFileMessage = null;
         var sofmsg:ServerOptionalFeaturesMessage = null;
         var ssmsg:ServerSettingsMessage = null;
         var ahm:AccountHouseMessage = null;
         var file:File = null;
         var featureId:int = 0;
         switch(true)
         {
            case msg is MouseRightClickMessage:
               mrcMsg=msg as MouseRightClickMessage;
               current=mrcMsg.target;
               stage=StageShareManager.stage;
               worldContainer=Atouin.getInstance().worldContainer;
               beriliaContainer=Berilia.getInstance().docMain;
               while((!(current==stage))&&(current))
               {
                  if(beriliaContainer==current)
                  {
                     return false;
                  }
                  current=current.parent;
               }
               KernelEventsManager.getInstance().processCallback(HookList.WorldRightClick);
               return true;
            case msg is CheckFileRequestMessage:
               cfrmsg=msg as CheckFileRequestMessage;
               fileStream=new FileStream();
               fileByte=new ByteArray();
               value="";
               filenameHash=MD5.hash(cfrmsg.filename);
               file=File.applicationDirectory;
               if((!file)||(!file.exists))
               {
                  value="-1";
               }
               else
               {
                  file=file.resolvePath("./"+cfrmsg.filename);
                  fileStream.open(file,FileMode.READ);
                  fileStream.readBytes(fileByte);
                  fileStream.close();
               }
               if(fileStream)
               {
                  fileStream.close();
               }
            case msg is ServerOptionalFeaturesMessage:
               sofmsg=msg as ServerOptionalFeaturesMessage;
               this._optionalAuthorizedFeatures=new Array();
               for each (featureId in sofmsg.features)
               {
                  this._optionalAuthorizedFeatures.push(featureId);
               }
               return true;
            case msg is ServerSettingsMessage:
               ssmsg=msg as ServerSettingsMessage;
               PlayerManager.getInstance().serverCommunityId=ssmsg.community;
               PlayerManager.getInstance().serverLang=ssmsg.lang;
               PlayerManager.getInstance().serverGameType=ssmsg.gameType;
               return true;
            case msg is AccountHouseMessage:
               ahm=msg as AccountHouseMessage;
               this._accountHouses=ahm.houses;
               KernelEventsManager.getInstance().processCallback(HookList.HouseInformations,ahm.houses);
               return true;
            default:
               return false;
         }
      }

      public function get priority() : int {
         return Priority.LOWEST;
      }
   }

}