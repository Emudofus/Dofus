package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectorySettings;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobCrafterDirectoryDefineSettingsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobCrafterDirectoryDefineSettingsMessage() {
         this.settings = new JobCrafterDirectorySettings();
         super();
      }
      
      public static const protocolId:uint = 5649;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var settings:JobCrafterDirectorySettings;
      
      override public function getMessageId() : uint {
         return 5649;
      }
      
      public function initJobCrafterDirectoryDefineSettingsMessage(settings:JobCrafterDirectorySettings = null) : JobCrafterDirectoryDefineSettingsMessage {
         this.settings = settings;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.settings = new JobCrafterDirectorySettings();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_JobCrafterDirectoryDefineSettingsMessage(output);
      }
      
      public function serializeAs_JobCrafterDirectoryDefineSettingsMessage(output:IDataOutput) : void {
         this.settings.serializeAs_JobCrafterDirectorySettings(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobCrafterDirectoryDefineSettingsMessage(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryDefineSettingsMessage(input:IDataInput) : void {
         this.settings = new JobCrafterDirectorySettings();
         this.settings.deserialize(input);
      }
   }
}
