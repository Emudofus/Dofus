package com.ankamagames.dofus.misc
{
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;

    public class BuildTypeParser 
    {


        public static function getTypeName(type:uint):String
        {
            switch (type)
            {
                case BuildTypeEnum.RELEASE:
                    return ("RELEASE");
                case BuildTypeEnum.BETA:
                    return ("BETA");
                case BuildTypeEnum.ALPHA:
                    return ("ALPHA");
                case BuildTypeEnum.TESTING:
                    return ("TESTING");
                case BuildTypeEnum.INTERNAL:
                    return ("INTERNAL");
                case BuildTypeEnum.DEBUG:
                    return ("DEBUG");
            };
            return ("UNKNOWN");
        }

        public static function getTypeColor(type:uint):uint
        {
            switch (type)
            {
                case BuildTypeEnum.RELEASE:
                    return (0x99CC00);
                case BuildTypeEnum.BETA:
                    return (0xFFCC00);
                case BuildTypeEnum.ALPHA:
                    return (0xFF9900);
                case BuildTypeEnum.TESTING:
                    return (0xFF6600);
                case BuildTypeEnum.INTERNAL:
                    return (6724095);
                case BuildTypeEnum.DEBUG:
                    return (10053375);
            };
            return (0xFFFFFF);
        }


    }
}//package com.ankamagames.dofus.misc

