package com.ankamagames.dofus.internalDatacenter.jobs
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
   
   public class KnownJob extends Object implements IDataCenter
   {
      
      public function KnownJob() {
         super();
      }
      
      public var jobDescription:JobDescription;
      
      public var jobExperience:JobExperience;
      
      public var jobPosition:int;
   }
}
