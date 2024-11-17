classdef Signal < handle

    properties
        time 
        values 
        name 
    end
    
    methods
        function this = Signal(name)
            this.name = name;
            this.time = [];
            this.values = [];
        end
        
        function appendTimeValue(this,value)
           if isempty(this.time)
                % Falls das Array leer ist, initialisieren wir es
                this.time = value;
            else
                % Füge den neuen Wert am Ende des Arrays hinzu
                this.time(end + 1) = value;
           end

        end
    
        function appendValue(this,value)
           if isempty(this.time)
                % Falls das Array leer ist, initialisieren wir es
                this.values = value;
            else
                % Füge den neuen Wert am Ende des Arrays hinzu
                this.values(end + 1) = value;
           end
          
        end


        function addValuePair(time, value)
            this.appendTimeValue(time);
            this.appendValue(value);
        end

        function a = getLastTimeValue(this)
            a = this.time(end);
        end

        function a = getLastValue(this)
            a = this.va(end);

        end



        
    end
end

