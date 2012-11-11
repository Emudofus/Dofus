package com.ankamagames.jerakine.logger.targets
{
    import com.ankamagames.jerakine.logger.targets.*;

    public interface ConfigurableLoggingTarget extends LoggingTarget
    {

        public function ConfigurableLoggingTarget();

        function configure(param1:XML) : void;

    }
}
