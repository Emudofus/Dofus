package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectorySettings;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class JobCrafterDirectoryDefineSettingsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobCrafterDirectoryDefineSettingsMessage()
      {
         this.settings = new JobCrafterDirectorySettings();
         super();
      }
      
      public static const protocolId:uint = 5649;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var settings:JobCrafterDirectorySettings;
      
      override public function getMessageId() : uint
      {
         return 5649;
      }
      
      public function initJobCrafterDirectoryDefineSettingsMessage(param1:JobCrafterDirectorySettings = null) : JobCrafterDirectoryDefineSettingsMessage
      {
         this.settings = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.settings = new JobCrafterDirectorySettings();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_JobCrafterDirectoryDefineSettingsMessage(param1);
      }
      
      public function serializeAs_JobCrafterDirectoryDefineSettingsMessage(param1:ICustomDataOutput) : void
      {
         this.settings.serializeAs_JobCrafterDirectorySettings(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectoryDefineSettingsMessage(param1);
      }
      
      public function deserializeAs_JobCrafterDirectoryDefineSettingsMessage(param1:ICustomDataInput) : void
      {
         this.settings = new JobCrafterDirectorySettings();
         this.settings.deserialize(param1);
      }
   }
}
