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
      
      public static function create(informations:JobCrafterDirectoryListEntry) : CraftsmanWrapper {
         var obj:CraftsmanWrapper = new CraftsmanWrapper();
         obj.playerId = informations.playerInfo.playerId;
         obj.playerName = informations.playerInfo.playerName;
         obj.alignmentSide = informations.playerInfo.alignmentSide;
         obj.breed = informations.playerInfo.breed;
         obj.sex = informations.playerInfo.sex;
         obj.isInWorkshop = informations.playerInfo.isInWorkshop;
         obj.mapId = informations.playerInfo.mapId;
         obj.subAreaId = informations.playerInfo.subAreaId;
         obj.worldPos = "(" + informations.playerInfo.worldX + ", " + informations.playerInfo.worldY + ")";
         obj.statusId = informations.playerInfo.status.statusId;
         if(informations.playerInfo.status is PlayerStatusExtended)
         {
            obj.awayMessage = PlayerStatusExtended(informations.playerInfo.status).message;
         }
         obj.jobId = informations.jobInfo.jobId;
         obj.jobLevel = informations.jobInfo.jobLevel;
         obj.minSlots = informations.jobInfo.minSlots;
         obj.specialization = Job.getJobById(informations.jobInfo.jobId).specializationOfId > 0;
         obj.notFree = !((informations.jobInfo.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE) == 0);
         obj.notFreeExceptOnFail = !((informations.jobInfo.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE_EXCEPT_ON_FAIL) == 0);
         obj.resourcesRequired = !((informations.jobInfo.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_RESOURCES_REQUIRED) == 0);
         return obj;
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
