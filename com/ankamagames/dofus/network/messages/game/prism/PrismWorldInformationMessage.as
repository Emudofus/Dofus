package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.prism.PrismSubAreaInformation;
   import com.ankamagames.dofus.network.types.game.prism.VillageConquestPrismInformation;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class PrismWorldInformationMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function PrismWorldInformationMessage() {
         this.subAreasInformation=new Vector.<PrismSubAreaInformation>();
         this.conquetesInformation=new Vector.<VillageConquestPrismInformation>();
         super();
      }

      public static const protocolId:uint = 5854;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var nbSubOwned:uint = 0;

      public var subTotal:uint = 0;

      public var maxSub:uint = 0;

      public var subAreasInformation:Vector.<PrismSubAreaInformation>;

      public var nbConqsOwned:uint = 0;

      public var conqsTotal:uint = 0;

      public var conquetesInformation:Vector.<VillageConquestPrismInformation>;

      override public function getMessageId() : uint {
         return 5854;
      }

      public function initPrismWorldInformationMessage(nbSubOwned:uint=0, subTotal:uint=0, maxSub:uint=0, subAreasInformation:Vector.<PrismSubAreaInformation>=null, nbConqsOwned:uint=0, conqsTotal:uint=0, conquetesInformation:Vector.<VillageConquestPrismInformation>=null) : PrismWorldInformationMessage {
         this.nbSubOwned=nbSubOwned;
         this.subTotal=subTotal;
         this.maxSub=maxSub;
         this.subAreasInformation=subAreasInformation;
         this.nbConqsOwned=nbConqsOwned;
         this.conqsTotal=conqsTotal;
         this.conquetesInformation=conquetesInformation;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.nbSubOwned=0;
         this.subTotal=0;
         this.maxSub=0;
         this.subAreasInformation=new Vector.<PrismSubAreaInformation>();
         this.nbConqsOwned=0;
         this.conqsTotal=0;
         this.conquetesInformation=new Vector.<VillageConquestPrismInformation>();
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
         this.serializeAs_PrismWorldInformationMessage(output);
      }

      public function serializeAs_PrismWorldInformationMessage(output:IDataOutput) : void {
         if(this.nbSubOwned<0)
         {
            throw new Error("Forbidden value ("+this.nbSubOwned+") on element nbSubOwned.");
         }
         else
         {
            output.writeInt(this.nbSubOwned);
            if(this.subTotal<0)
            {
               throw new Error("Forbidden value ("+this.subTotal+") on element subTotal.");
            }
            else
            {
               output.writeInt(this.subTotal);
               if(this.maxSub<0)
               {
                  throw new Error("Forbidden value ("+this.maxSub+") on element maxSub.");
               }
               else
               {
                  output.writeInt(this.maxSub);
                  output.writeShort(this.subAreasInformation.length);
                  _i4=0;
                  while(_i4<this.subAreasInformation.length)
                  {
                     (this.subAreasInformation[_i4] as PrismSubAreaInformation).serializeAs_PrismSubAreaInformation(output);
                     _i4++;
                  }
                  if(this.nbConqsOwned<0)
                  {
                     throw new Error("Forbidden value ("+this.nbConqsOwned+") on element nbConqsOwned.");
                  }
                  else
                  {
                     output.writeInt(this.nbConqsOwned);
                     if(this.conqsTotal<0)
                     {
                        throw new Error("Forbidden value ("+this.conqsTotal+") on element conqsTotal.");
                     }
                     else
                     {
                        output.writeInt(this.conqsTotal);
                        output.writeShort(this.conquetesInformation.length);
                        _i7=0;
                        while(_i7<this.conquetesInformation.length)
                        {
                           (this.conquetesInformation[_i7] as VillageConquestPrismInformation).serializeAs_VillageConquestPrismInformation(output);
                           _i7++;
                        }
                        return;
                     }
                  }
               }
            }
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismWorldInformationMessage(input);
      }

      public function deserializeAs_PrismWorldInformationMessage(input:IDataInput) : void {
         var _item4:PrismSubAreaInformation = null;
         var _item7:VillageConquestPrismInformation = null;
         this.nbSubOwned=input.readInt();
         if(this.nbSubOwned<0)
         {
            throw new Error("Forbidden value ("+this.nbSubOwned+") on element of PrismWorldInformationMessage.nbSubOwned.");
         }
         else
         {
            this.subTotal=input.readInt();
            if(this.subTotal<0)
            {
               throw new Error("Forbidden value ("+this.subTotal+") on element of PrismWorldInformationMessage.subTotal.");
            }
            else
            {
               this.maxSub=input.readInt();
               if(this.maxSub<0)
               {
                  throw new Error("Forbidden value ("+this.maxSub+") on element of PrismWorldInformationMessage.maxSub.");
               }
               else
               {
                  _subAreasInformationLen=input.readUnsignedShort();
                  _i4=0;
                  while(_i4<_subAreasInformationLen)
                  {
                     _item4=new PrismSubAreaInformation();
                     _item4.deserialize(input);
                     this.subAreasInformation.push(_item4);
                     _i4++;
                  }
                  this.nbConqsOwned=input.readInt();
                  if(this.nbConqsOwned<0)
                  {
                     throw new Error("Forbidden value ("+this.nbConqsOwned+") on element of PrismWorldInformationMessage.nbConqsOwned.");
                  }
                  else
                  {
                     this.conqsTotal=input.readInt();
                     if(this.conqsTotal<0)
                     {
                        throw new Error("Forbidden value ("+this.conqsTotal+") on element of PrismWorldInformationMessage.conqsTotal.");
                     }
                     else
                     {
                        _conquetesInformationLen=input.readUnsignedShort();
                        _i7=0;
                        while(_i7<_conquetesInformationLen)
                        {
                           _item7=new VillageConquestPrismInformation();
                           _item7.deserialize(input);
                           this.conquetesInformation.push(_item7);
                           _i7++;
                        }
                        return;
                     }
                  }
               }
            }
         }
      }
   }

}