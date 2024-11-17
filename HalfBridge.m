classdef HalfBridge < handle
    %HBRIDGE Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Vgs  (:,:) Signal
        voltageHigh
        voltageLow
    end

    methods
        function this = HalfBridge(voltageHigh, voltageLow)
            names = ["HS" "LS"];
            for i = 1:2
                this.Vgs(i) = Signal(names(i));
            end

            this.voltageHigh = voltageHigh;
            this.voltageLow = voltageLow;
        end

        
        function plotAllSignals(this)
            for i = 1:length(this.Vgs)
                subplot(2,1,i);
                plot(this.Vgs(i).time, this.Vgs(i).values);
                title(this.Vgs(i).name);
                xlabel("time / s");
                ylabel("Voltage / V");
                hold on;
                grid;
            end
            

        end

        function init(this, state)
            this.Vgs(1).appendTimeValue(0);
            this.Vgs(2).appendTimeValue(0);

            if state == 1
                % HB on
                this.Vgs(1).appendValue(this.voltageHigh);
                this.Vgs(2).appendValue(this.voltageLow);
            elseif state == -1
                this.Vgs(1).appendValue(this.voltageLow);
                this.Vgs(2).appendValue(this.voltageHigh);
            elseif state == 0
               this.Vgs(1).appendValue(this.voltageLow);
                this.Vgs(2).appendValue(this.voltageLow);
            end
        end

        function moveForwardInTime(this, amount)
            % moves forward in time and keeps the previous values

            for i = 1:length(this.Vgs)
                lastTimeValue = this.Vgs(i).time(end);
                this.Vgs(i).appendTimeValue( lastTimeValue + amount);

                lastValue = this.Vgs(i).values(end);
                this.Vgs(i).appendValue(lastValue);
            end
        end

        function swtch(this, state, deadtime)
                lastTimeValue = this.Vgs(1).getLastTimeValue();
                this.Vgs(1).appendTimeValue(lastTimeValue + deadtime);
                this.Vgs(2).appendTimeValue(lastTimeValue + deadtime);

                if isequal(state, 1)
                    this.Vgs(1).appendValue(this.voltageHigh);
                    this.Vgs(2).appendValue(this.voltageLow);
                elseif isequal(state, -1)
                    this.Vgs(1).appendValue(this.voltageLow);
                    this.Vgs(2).appendValue(this.voltageHigh);
                elseif isequal(state, 0)
                    this.Vgs(1).appendValue(this.voltageLow);
                    this.Vgs(2).appendValue(this.voltageLow);

                end

        end
        
    end

end
