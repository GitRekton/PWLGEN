classdef HBridge < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        hb1 HalfBridge
        hb2 HalfBridge
    end

    methods
        function this = HBridge(halfbridge1, halfbridge2)
            this.hb1 = halfbridge1;
            this.hb2 = halfbridge2;
        end


        function plotAllSignals(this)
            figure(1);
            this.hb1.plotAllSignals();

            figure(2);
            this.hb2.plotAllSignals();


        end

        function init(this, hb1State, hb2State)
            this.hb1.init(hb1State);
            this.hb2.init(hb2State);
        end

        function moveForwardInTime(this, amount)
            this.hb1.moveForwardInTime(amount);
            this.hb2.moveForwardInTime(amount);
        end

        function swtch(this, hb, deadtime)

        end

        function exportAllSignalsToPWL(this)
            this.convertToPWL("LeftHB_HS.txt", this.hb1.Vgs(1).time, this.hb1.Vgs(1).values);
            this.convertToPWL("LeftHB_LS.txt", this.hb1.Vgs(2).time, this.hb1.Vgs(2).values);
            this.convertToPWL("RightHB_HS.txt", this.hb2.Vgs(1).time, this.hb2.Vgs(1).values);
            this.convertToPWL("RightHB_LS.txt", this.hb2.Vgs(2).time, this.hb1.Vgs(2).values);
        end

        function convertToPWL(this, filename, time, values)
            % convertToPWL - Konvertiert Zeit- und Wert-Vektoren in eine PWL-Datei.
            %
            % Syntax:
            %   convertToPWL(filename, time, values)
            %
            % Inputs:
            %   filename - String, Name der Ausgabedatei (z. B. 'signal.pwl')
            %   time     - Vektor mit Zeitwerten
            %   values   - Vektor oder Matrix mit Werten (jede Spalte ein Signal)
            %
            % Example:
            %   time = [0, 1, 2, 3];
            %   values = [0, 5, 10, 15];
            %   convertToPWL('output.pwl', time, values);
            %
            % Hinweis: Zeit- und Werte-Vektoren müssen dieselbe Länge haben.

            % Validierung der Eingaben
            if ~isequal(length(time), length(values))
                error('Die Länge des Zeitvektors muss mit der Anzahl der Zeilen von "values" übereinstimmen.');
            end

            % Öffne die Datei
            fileID = fopen(filename, 'w');
            if fileID == -1
                error('Datei konnte nicht geöffnet werden: %s', filename);
            end

            % Schreibe Daten in die Datei
            try
                if isvector(values)
                    % Falls `values` ein Vektor ist
                    for i = 1:length(time)
                        fprintf(fileID, '%f %f\n', time(i), values(i));
                    end
                else
                    % Falls `values` eine Matrix ist
                    numSignals = size(values, 2);
                    for i = 1:length(time)
                        fprintf(fileID, '%f', time(i)); % Zeit
                        for j = 1:numSignals
                            fprintf(fileID, ' %f', values(i, j)); % Werte
                        end
                        fprintf(fileID, '\n');
                    end
                end
            catch ME
                fclose(fileID);
                rethrow(ME);
            end

            % Schließe die Datei
            fclose(fileID);
            fprintf('PWL-Datei "%s" erfolgreich erstellt.\n', filename);
        end

    end
end

