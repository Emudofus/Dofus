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
      
      public function initServerExperienceModificatorMessage(param1:uint=0) : ServerExperienceModificatorMessage {
         this.experiencePercent = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.experiencePercent = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ServerExperienceModificatorMessage(param1);
      }
      
      public function serializeAs_ServerExperienceModificatorMessage(param1:IDataOutput) : void {
         if(this.experiencePercent < 0)
         {
            throw new Error("Forbidden value (" + this.experiencePercent + ") on element experiencePercent.");
         }
         else
         {
            param1.writeShort(this.experiencePercent);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ServerExperienceModificatorMessage(param1);
      }
      
      public function deserializeAs_ServerExperienceModificatorMessage(param1:IDataInput) : void {
         this.experiencePercent = param1.readShort();
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
