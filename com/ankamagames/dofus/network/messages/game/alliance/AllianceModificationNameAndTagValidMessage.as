package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceModificationNameAndTagValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceModificationNameAndTagValidMessage() {
         super();
      }
      
      public static const protocolId:uint = 6449;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var allianceName:String = "";
      
      public var allianceTag:String = "";
      
      override public function getMessageId() : uint {
         return 6449;
      }
      
      public function initAllianceModificationNameAndTagValidMessage(allianceName:String="", allianceTag:String="") : AllianceModificationNameAndTagValidMessage {
         this.allianceName = allianceName;
         this.allianceTag = allianceTag;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.allianceName = "";
         this.allianceTag = "";
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
         this.serializeAs_AllianceModificationNameAndTagValidMessage(output);
      }
      
      public function serializeAs_AllianceModificationNameAndTagValidMessage(output:IDataOutput) : void {
         output.writeUTF(this.allianceName);
         output.writeUTF(this.allianceTag);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceModificationNameAndTagValidMessage(input);
      }
      
      public function deserializeAs_AllianceModificationNameAndTagValidMessage(input:IDataInput) : void {
         this.allianceName = input.readUTF();
         this.allianceTag = input.readUTF();
      }
   }
}
