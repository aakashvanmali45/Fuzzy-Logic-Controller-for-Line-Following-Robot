x = out.x_out.signals.values;
y = out.y_out.signals.values;

figure;
hold on;
grid on;

% Draw reference line (y = 0)
plot([-1 1], [0 0], 'k--', 'LineWidth', 2); 

% Robot path
plot(x, y, 'b', 'LineWidth', 2);

title('Robot Path Following Line');
xlabel('X Position (m)');
ylabel('Y Position (m)');
legend('Line', 'Robot Path');
axis equal;
