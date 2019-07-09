LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY buzzer_controller IS
    GENERIC(
        COUNTER_SIZE  :  INTEGER := 21;
        CLOCK_FREQUENCY : INTEGER := 50000000
    ); 
    PORT(
        clk : IN STD_LOGIC;
        game_status : IN INTEGER;
        enemy_ship_hit : IN STD_LOGIC;
        ship_hit : IN STD_LOGIC;
        fired_buzzer : IN STD_LOGIC;
        buzzer_control : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE buzzer_controller OF buzzer_controller IS
    signal prev_game_status : INTEGER := 0;
    signal time_counter : INTEGER(0 to COUNTER_SIZE) := 0;
    signal sound_period : INTEGER := 50 * (CLOCK_FREQUENCY / 1000);
    signal sound_cycles_counter : INTEGER := 0;
    signal sound_cycles : INTEGER;
    signal play_sound : STD_LOGIC := '0';
BEGIN
    -- Inicio do jogo, final do jogo, acerto de um inimigo, acerto da nave do player e a cada tiro disparado pelo player.
    PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            -- Toca o som
            IF play_sound = '1' and time_counter < sound_period / 2 THEN

            -- Verifica entradas e define qual som tocar
            ELSE
                IF game_status = 1 THEN
                    -- Jogador disparou
                    IF fired_buzzer = '1'
                        -- TIRO!
                    -- Jogador foi alvejado
                    ELSIF ship_hit = '1'
                        -- PAIN!
                    -- Inimigo foi alvejado
                    ELSIF enemy_ship_hit = '1'
                        -- DESTROY!
                    END IF;
                ELSIF game_status = 1 and prev_game_status != 1 THEN
                    -- Início do jogo
                ELSIF game_status = 3 and prev_game_status != 3 THEN
                    -- Game over :(
                ELSE
                    play_sound = '0';
                END IF;
            END IF;

            prev_game_status <= game_status;

        END IF;
    END PROCESS;
END;