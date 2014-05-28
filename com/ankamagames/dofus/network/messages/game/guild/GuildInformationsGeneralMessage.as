package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class GuildInformationsGeneralMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildInformationsGeneralMessage() {
         super();
      }
      
      public static const protocolId:uint = 5557;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var enabled:Boolean = false;
      
      public var abandonnedPaddock:Boolean = false;
      
      public var level:uint = 0;
      
      public var expLevelFloor:Number = 0;
      
      public var experience:Number = 0;
      
      public var expNextLevelFloor:Number = 0;
      
      public var creationDate:uint = 0;
      
      public var nbTotalMembers:uint = 0;
      
      public var nbConnectedMembers:uint = 0;
      
      override public function getMessageId() : uint {
         return 5557;
      }
      
      public function initGuildInformationsGeneralMessage(enabled:Boolean = false, abandonnedPaddock:Boolean = false, level:uint = 0, expLevelFloor:Number = 0, experience:Number = 0, expNextLevelFloor:Number = 0, creationDate:uint = 0, nbTotalMembers:uint = 0, nbConnectedMembers:uint = 0) : GuildInformationsGeneralMessage {
         this.enabled = enabled;
         this.abandonnedPaddock = abandonnedPaddock;
         this.level = level;
         this.expLevelFloor = expLevelFloor;
         this.experience = experience;
         this.expNextLevelFloor = expNextLevelFloor;
         this.creationDate = creationDate;
         this.nbTotalMembers = nbTotalMembers;
         this.nbConnectedMembers = nbConnectedMembers;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.enabled = false;
         this.abandonnedPaddock = false;
         this.level = 0;
         this.expLevelFloor = 0;
         this.experience = 0;
         this.expNextLevelFloor = 0;
         this.creationDate = 0;
         this.nbTotalMembers = 0;
         this.nbConnectedMembers = 0;
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
         this.serializeAs_GuildInformationsGeneralMessage(output);
      }
      
      public function serializeAs_GuildInformationsGeneralMessage(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.enabled);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.abandonnedPaddock);
         output.writeByte(_box0);
         if((this.level < 0) || (this.level > 255))
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            output.writeByte(this.level);
            if(this.expLevelFloor < 0)
            {
               throw new Error("Forbidden value (" + this.expLevelFloor + ") on element expLevelFloor.");
            }
            else
            {
               output.writeDouble(this.expLevelFloor);
               if(this.experience < 0)
               {
                  throw new Error("Forbidden value (" + this.experience + ") on element experience.");
               }
               else
               {
                  output.writeDouble(this.experience);
                  if(this.expNextLevelFloor < 0)
                  {
                     throw new Error("Forbidden value (" + this.expNextLevelFloor + ") on element expNextLevelFloor.");
                  }
                  else
                  {
                     output.writeDouble(this.expNextLevelFloor);
                     if(this.creationDate < 0)
                     {
                        throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
                     }
                     else
                     {
                        output.writeInt(this.creationDate);
                        if(this.nbTotalMembers < 0)
                        {
                           throw new Error("Forbidden value (" + this.nbTotalMembers + ") on element nbTotalMembers.");
                        }
                        else
                        {
                           output.writeShort(this.nbTotalMembers);
                           if(this.nbConnectedMembers < 0)
                           {
                              throw new Error("Forbidden value (" + this.nbConnectedMembers + ") on element nbConnectedMembers.");
                           }
                           else
                           {
                              output.writeShort(this.nbConnectedMembers);
                              return;
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildInformationsGeneralMessage(input);
      }
      
      public function deserializeAs_GuildInformationsGeneralMessage(input:IDataInput) : void {
         var _box0:uint = input.readByte();
         this.enabled = BooleanByteWrapper.getFlag(_box0,0);
         this.abandonnedPaddock = BooleanByteWrapper.getFlag(_box0,1);
         this.level = input.readUnsignedByte();
         if((this.level < 0) || (this.level > 255))
         {
            throw new Error("Forbidden value (" + this.level + ") on element of GuildInformationsGeneralMessage.level.");
         }
         else
         {
            this.expLevelFloor = input.readDouble();
            if(this.expLevelFloor < 0)
            {
               throw new Error("Forbidden value (" + this.expLevelFloor + ") on element of GuildInformationsGeneralMessage.expLevelFloor.");
            }
            else
            {
               this.experience = input.readDouble();
               if(this.experience < 0)
               {
                  throw new Error("Forbidden value (" + this.experience + ") on element of GuildInformationsGeneralMessage.experience.");
               }
               else
               {
                  this.expNextLevelFloor = input.readDouble();
                  if(this.expNextLevelFloor < 0)
                  {
                     throw new Error("Forbidden value (" + this.expNextLevelFloor + ") on element of GuildInformationsGeneralMessage.expNextLevelFloor.");
                  }
                  else
                  {
                     this.creationDate = input.readInt();
                     if(this.creationDate < 0)
                     {
                        throw new Error("Forbidden value (" + this.creationDate + ") on element of GuildInformationsGeneralMessage.creationDate.");
                     }
                     else
                     {
                        this.nbTotalMembers = input.readShort();
                        if(this.nbTotalMembers < 0)
                        {
                           throw new Error("Forbidden value (" + this.nbTotalMembers + ") on element of GuildInformationsGeneralMessage.nbTotalMembers.");
                        }
                        else
                        {
                           this.nbConnectedMembers = input.readShort();
                           if(this.nbConnectedMembers < 0)
                           {
                              throw new Error("Forbidden value (" + this.nbConnectedMembers + ") on element of GuildInformationsGeneralMessage.nbConnectedMembers.");
                           }
                           else
                           {
                              return;
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
