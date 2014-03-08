package com.ankamagames.dofus.internalDatacenter.jobs
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryListEntry;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.network.enums.CrafterDirectoryParamBitEnum;
   
   public class CraftsmanWrapper extends Object implements IDataCenter
   {
      
      public function CraftsmanWrapper() {
         super();
      }
      
      public static function create(param1:JobCrafterDirectoryListEntry) : CraftsmanWrapper {
         var _loc2_:CraftsmanWrapper = new CraftsmanWrapper();
         _loc2_.playerId = param1.playerInfo.playerId;
         _loc2_.playerName = param1.playerInfo.playerName;
         _loc2_.alignmentSide = param1.playerInfo.alignmentSide;
         _loc2_.breed = param1.playerInfo.breed;
         _loc2_.sex = param1.playerInfo.sex;
         _loc2_.isInWorkshop = param1.playerInfo.isInWorkshop;
         _loc2_.mapId = param1.playerInfo.mapId;
         _loc2_.subAreaId = param1.playerInfo.subAreaId;
         _loc2_.worldPos = "(" + param1.playerInfo.worldX + ", " + param1.playerInfo.worldY + ")";
         _loc2_.statusId = param1.playerInfo.status.statusId;
         if(param1.playerInfo.status is PlayerStatusExtended)
         {
            _loc2_.awayMessage = PlayerStatusExtended(param1.playerInfo.status).message;
         }
         _loc2_.jobId = param1.jobInfo.jobId;
         _loc2_.jobLevel = param1.jobInfo.jobLevel;
         _loc2_.minSlots = param1.jobInfo.minSlots;
         _loc2_.specialization = Job.getJobById(param1.jobInfo.jobId).specializationOfId > 0;
         _loc2_.notFree = !((param1.jobInfo.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE) == 0);
         _loc2_.notFreeExceptOnFail = !((param1.jobInfo.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE_EXCEPT_ON_FAIL) == 0);
         _loc2_.resourcesRequired = !((param1.jobInfo.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_RESOURCES_REQUIRED) == 0);
         return _loc2_;
      }
      
      public var playerId:int;
      
      public var playerName:String;
      
      public var alignmentSide:int;
      
      public var breed:int;
      
      public var sex:Boolean;
      
      public var isInWorkshop:Boolean = false;
      
      public var mapId:int;
      
      public var subAreaId:int;
      
      public var worldPos:String;
      
      public var statusId:int;
      
      public var awayMessage:String;
      
      public var jobId:int;
      
      public var jobLevel:int;
      
      public var minSlots:int;
      
      public var specialization:Boolean;
      
      public var notFree:Boolean;
      
      public var notFreeExceptOnFail:Boolean;
      
      public var resourcesRequired:Boolean;
   }
}
