package com.ankamagames.dofus.network.messages.game.initialization
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ServerExperienceModificatorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ServerExperienceModificatorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6237;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var experiencePercent:uint = 0;
      
      override public function getMessageId() : uint {
         return 6237;
      }
      
      public function initServerExperienceModificatorMessage(experiencePercent:uint=0) : ServerExperienceModificatorMessage {
         this.experiencePercent = experiencePercent;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.experiencePercent = 0;
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
         this.serializeAs_ServerExperienceModificatorMessage(output);
      }
      
      public function serializeAs_ServerExperienceModificatorMessage(output:IDataOutput) : void {
         if(this.experiencePercent < 0)
         {
            throw new Error("Forbidden value (" + this.experiencePercent + ") on element experiencePercent.");
         }
         else
         {
            output.writeShort(this.experiencePercent);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ServerExperienceModificatorMessage(input);
      }
      
      public function deserializeAs_ServerExperienceModificatorMessage(input:IDataInput) : void {
         this.experiencePercent = input.readShort();
         if(this.experiencePercent < 0)
         {
            throw new Error("Forbidden value (" + this.experiencePercent + ") on element of ServerExperienceModificatorMessage.experiencePercent.");
         }
         else
         {
            return;
         }
      }
   }
}
