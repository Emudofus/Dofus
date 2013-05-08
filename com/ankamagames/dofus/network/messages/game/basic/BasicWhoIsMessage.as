package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class BasicWhoIsMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function BasicWhoIsMessage() {
         super();
      }

      public static const protocolId:uint = 180;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var self:Boolean = false;

      public var position:int = 0;

      public var accountNickname:String = "";

      public var accountId:uint = 0;

      public var playerName:String = "";

      public var playerId:uint = 0;

      public var areaId:int = 0;

      override public function getMessageId() : uint {
         return 180;
      }

      public function initBasicWhoIsMessage(self:Boolean=false, position:int=0, accountNickname:String="", accountId:uint=0, playerName:String="", playerId:uint=0, areaId:int=0) : BasicWhoIsMessage {
         this.self=self;
         this.position=position;
         this.accountNickname=accountNickname;
         this.accountId=accountId;
         this.playerName=playerName;
         this.playerId=playerId;
         this.areaId=areaId;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.self=false;
         this.position=0;
         this.accountNickname="";
         this.accountId=0;
         this.playerName="";
         this.playerId=0;
         this.areaId=0;
         this._isInitialized=false;
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
         this.serializeAs_BasicWhoIsMessage(output);
      }

      public function serializeAs_BasicWhoIsMessage(output:IDataOutput) : void {
         output.writeBoolean(this.self);
         output.writeByte(this.position);
         output.writeUTF(this.accountNickname);
         if(this.accountId<0)
         {
            throw new Error("Forbidden value ("+this.accountId+") on element accountId.");
         }
         else
         {
            output.writeInt(this.accountId);
            output.writeUTF(this.playerName);
            if(this.playerId<0)
            {
               throw new Error("Forbidden value ("+this.playerId+") on element playerId.");
            }
            else
            {
               output.writeInt(this.playerId);
               output.writeShort(this.areaId);
               return;
            }
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicWhoIsMessage(input);
      }

      public function deserializeAs_BasicWhoIsMessage(input:IDataInput) : void {
         this.self=input.readBoolean();
         this.position=input.readByte();
         this.accountNickname=input.readUTF();
         this.accountId=input.readInt();
         if(this.accountId<0)
         {
            throw new Error("Forbidden value ("+this.accountId+") on element of BasicWhoIsMessage.accountId.");
         }
         else
         {
            this.playerName=input.readUTF();
            this.playerId=input.readInt();
            if(this.playerId<0)
            {
               throw new Error("Forbidden value ("+this.playerId+") on element of BasicWhoIsMessage.playerId.");
            }
            else
            {
               this.areaId=input.readShort();
               return;
            }
         }
      }
   }

}