import { Hono } from 'hono';
import { bookRoutes } from './bookRoutes'; 
import { authRoutes} from './authRoutes'
const v1 = new Hono;

v1.get('/health', (c) => {
    return c.json({
        status: 'OK',
        timeStamp: new Date().toISOString()
    });
});

v1.route('/books', bookRoutes);
v1.route('/auth', authRoutes);

export { v1 };