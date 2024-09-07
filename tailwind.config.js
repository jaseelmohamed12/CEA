import defaultTheme from 'tailwindcss/defaultTheme';
import forms from '@tailwindcss/forms';
import typography from '@tailwindcss/typography';
import { yellow } from '@tailwindcss/ui/colors';

/** @type {import('tailwindcss').Config} */
export default {
    content: [
        './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
        './vendor/laravel/jetstream/**/*.blade.php',
        './storage/framework/views/*.php',
        './resources/views/**/*.blade.php',
        './resources/js/**/*.vue',
    ],

    theme: {
        extend: {
            fontFamily: {
                sans: ['Figtree', ...defaultTheme.fontFamily.sans],
            },
            colors: {
                green1: '#5BB98A',
                green2: '#01565B',
                green3: '#016553',
                green4: '#4D5358',
                lightergray: "#E1F29680",
                customGray: '#FAFCFC',
                yellow1: "#E1F296",
                black1: '#131313',
            },
            spacing: {
                '0.2rem': '0.2rem', 
            }
        },
    },

    plugins: [forms, typography],
};
