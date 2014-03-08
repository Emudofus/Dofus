package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectorySettings;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobCrafterDirectorySettingsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobCrafterDirectorySettingsMessage() {
         this.craftersSettings = new Vector.<JobCrafterDirectorySettings>();
         super();
      }
      
      public static const protocolId:uint = 5652;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var craftersSettings:Vector.<JobCrafterDirectorySettings>;
      
      override public function getMessageId() : uint {
         return 5652;
      }
      
      public function initJobCrafterDirectorySettingsMessage(craftersSettings:Vector.<JobCrafterDirectorySettings>=null) : JobCrafterDirectorySettingsMessage {
         this.craftersSettings = craftersSettings;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.craftersSettings = new Vector.<JobCrafterDirectorySettings>();
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
         this.serializeAs_JobCrafterDirectorySettingsMessage(output);
      }
      
      public function serializeAs_JobCrafterDirectorySettingsMessage(output:IDataOutput) : void {
         output.writeShort(this.craftersSettings.length);
         var _i1:uint = 0;
         while(_i1 < this.craftersSettings.length)
         {
            (this.craftersSettings[_i1] as JobCrafterDirectorySettings).serializeAs_JobCrafterDirectorySettings(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobCrafterDirectorySettingsMessage(input);
      }
      
      public function deserializeAs_JobCrafterDirectorySettingsMessage(input:IDataInput) : void {
         var _item1:JobCrafterDirectorySettings = null;
         var _craftersSettingsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _craftersSettingsLen)
         {
            _item1 = new JobCrafterDirectorySettings();
            _item1.deserialize(input);
            this.craftersSettings.push(_item1);
            _i1++;
         }
      }
   }
}
