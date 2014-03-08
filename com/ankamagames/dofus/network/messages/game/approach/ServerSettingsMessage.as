package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ServerSettingsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ServerSettingsMessage() {
         super();
      }
      
      public static const protocolId:uint = 6340;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var lang:String = "";
      
      public var community:uint = 0;
      
      public var gameType:uint = 0;
      
      override public function getMessageId() : uint {
         return 6340;
      }
      
      public function initServerSettingsMessage(lang:String="", community:uint=0, gameType:uint=0) : ServerSettingsMessage {
         this.lang = lang;
         this.community = community;
         this.gameType = gameType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.lang = "";
         this.community = 0;
         this.gameType = 0;
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
         this.serializeAs_ServerSettingsMessage(output);
      }
      
      public function serializeAs_ServerSettingsMessage(output:IDataOutput) : void {
         output.writeUTF(this.lang);
         if(this.community < 0)
         {
            throw new Error("Forbidden value (" + this.community + ") on element community.");
         }
         else
         {
            output.writeByte(this.community);
            if(this.gameType < 0)
            {
               throw new Error("Forbidden value (" + this.gameType + ") on element gameType.");
            }
            else
            {
               output.writeByte(this.gameType);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ServerSettingsMessage(input);
      }
      
      public function deserializeAs_ServerSettingsMessage(input:IDataInput) : void {
         this.lang = input.readUTF();
         this.community = input.readByte();
         if(this.community < 0)
         {
            throw new Error("Forbidden value (" + this.community + ") on element of ServerSettingsMessage.community.");
         }
         else
         {
            this.gameType = input.readByte();
            if(this.gameType < 0)
            {
               throw new Error("Forbidden value (" + this.gameType + ") on element of ServerSettingsMessage.gameType.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
